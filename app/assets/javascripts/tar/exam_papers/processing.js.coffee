app = window.app

app.controller('ExamPapersProcessingCtrl', ['$scope', ($scope) ->
  $scope.exam_papers = [
    {
      year: '2012', province_text: '北京市', arts_science_text: '文科',
      choice_questions: [
        {number: 1}, {number: 2}, {number: 3}, {number: 4}, {number: 5},
        {number: 6}, {number: 7}, {number: 8}, {number: 9}, {number: 10}
      ],
      filling_questions: [],
      answering_questions: []
    },
    {
      year: '2012', province_text: '河北省', arts_science_text: '理科',
      choice_questions: [],
      filling_questions: [{number: 14}, {number: 15}, {number: 16}],
      answering_questions: null
    }
  ]

  calcMaxQuestions = (exam_papers, questions_key) ->
    return 1 if !exam_papers? or exam_papers.length is 0
    max = _.max(_.map(exam_papers, (paper) -> (paper[questions_key] ? []).length))
    max = 1 if max is 0
    _.each exam_papers, (paper) ->
      paper[questions_key] ?= []
      if paper[questions_key].length < max
        _.times (max - paper[questions_key].length), -> paper[questions_key].push({})
    max

  $scope.maxChoiceQuestions = calcMaxQuestions($scope.exam_papers, 'choice_questions')
  $scope.maxFillingQuestions = calcMaxQuestions($scope.exam_papers, 'filling_questions')
  $scope.maxAnsweringQuestions = calcMaxQuestions($scope.exam_papers, 'answering_questions')
])
