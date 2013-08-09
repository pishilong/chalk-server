# encoding: utf-8

class Chalk::GzMath::Keypoint < Chalk::Base
  # extends ...................................................................

  # includes ..................................................................
  include ActiveModel::ForbiddenAttributesProtection
  include TarActivity

  include OrderIdx
  order_idx_scope [:tree_id, :p_id]

  # relationships .............................................................
  belongs_to :tree, class_name: 'GzMath::Tree'
  belongs_to :parent, class_name: 'GzMath::Keypoint', foreign_key: 'p_id'
  has_many :children, class_name: 'GzMath::Keypoint', foreign_key: 'p_id',
    order: 'order_idx ASC', dependent: :destroy
  has_many :keypoints_exercises, class_name: 'GzMath::KeypointsExercise',
    dependent: :destroy
  has_many :exam_papers_sections_exercises,
    class_name: 'GzMath::ExamPapersSectionsExercise',
    through: :keypoints_exercises
  has_many :keypoints_exam_exercises, class_name: 'GzMath::KeypointsExamExercise',
    dependent: :destroy

  # constants definition ......................................................

  # validations ...............................................................
  validates :node_name, presence: true, uniqueness: {
    scope: [:tree_id, :p_id]
  }

  # callbacks .................................................................
  before_save :set_level, if: -> { tree_id_changed? || p_id_changed? }
  after_update :update_level_for_children, if: :level_changed?
  before_update :update_order_idx, if: -> { tree_id_changed? || p_id_changed? }

  # scopes ....................................................................

  # additional config .........................................................

  # 自动 strip 且空字符串看做 nil 处理
  normalize_attributes :content

  # class methods .............................................................
  def self.get_tree
    data = []
    GzMath::Tree.where(p_id: nil).order("order_idx ASC").each do |node|
      data << make_tree_data(node)
    end
    data
  end

  def self.make_keypoint_data(node, is_keypoint)
    relation = is_keypoint ? node.children : node.keypoints
    relation.select('id, node_name, content, level, order_idx').map do |kp|
      children = make_keypoint_data(kp, true)
      if children.empty?
        icon_skin = 'keypoint-node'
      else
        icon_skin = 'second-level-keypoint-node'
      end
      {
        name: kp.name_in_tree,
        kp_name: kp.node_name,
        kp_content: kp.content,
        order_idx: kp.order_idx,
        id: kp.id,
        isKeypoint: true,
        kp_level: kp.level,
        iconSkin: icon_skin,
        isParent: !children.empty?,
        children: children
      }
    end
  end

  def self.make_tree_data(node)
    tree_data = {}
    tree_data[:name] = node.node_name
    tree_data[:level] = node.level
    tree_data[:id] = "n_#{node.id}"
    tree_data[:isParent] = true
    tree_data[:tree] = true
    if node.leaf?
      tree_data[:_leaf] = true
      tree_data[:children] = make_keypoint_data(node, false)
    else
      tree_data[:children] = []
      node.children.each do |category|
        tree_data[:children] << make_tree_data(category)
      end
    end
    tree_data
  end

  # public instance methods ...................................................
  def leaf?
    self.children.size == 0
  end

  def chapter
    top_keypoint = self
    loop do
      parent = top_keypoint.parent
      break if parent.nil?
      top_keypoint = parent
    end
    top_keypoint.tree
  end

  def chapter_name
    chapter.nil? ? '' : chapter.node_name
  end

  def name_in_tree
    _title = content ? "#{node_name}：#{content}" : node_name
    "#{order_idx}. #{_title}"
  end

  def has_children?
    children.any?
  end

  def keypoints
    self.children.reject { |node| node.has_children? }
  end

  # @note 获得叶子节点
  def leaf_keypoints
    result = []
    if self.has_children?
      self.children.each do |kp|
        result += kp.leaf_keypoints
      end
    else
      result << self
    end
    result
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
  private

  def update_order_idx
    logger.debug(:update_order_idx) do
      "tree_id: #{tree_id}, tree_id was: #{tree_id_was}, \
      p_id: #{p_id}, p_id was: #{p_id_was}"
    end

    self.order_idx ||= order_idx_relation.count + 1

    tmp = self.dup
    tmp.id = self.id
    tmp.tree_id = tree_id_was
    tmp.p_id = p_id_was
    tmp.rearrange_order_idx(exclude_self: true)

    nil
  end

  def set_level
    if self.p_id
      self.level = self.parent.level + 1
    else
      self.level = 0
    end

    nil
  end

  def update_level_for_children
    _level = self.level + 1
    self.children.each {|c| c.update_attributes(level: _level) if c.level != _level }
    nil
  end
end
