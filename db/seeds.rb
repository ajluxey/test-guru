# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(email: 'v_koralina@list.ru',
                    login: 'ajluxey',
                    password: 'qwerty',
                    type: 'Admin',
                    first_name: 'Alesha',
                    last_name: "Aliheev")
categories = Category.create!([{ title: 'Ruby' }, { title: 'Алгоритмы' }])
tests = Test.create!([{ title: 'Основы Ruby', category: categories[0], author: user },
                      { title: 'Сортировки', level: 2, category: categories[1], author: user },
                      { title: 'Ruby - Экспертный тест', level: 10, category: categories[0], author: user },
                      { title: 'Алгоритмы сжатия информации', level: 2, category: categories[1], author: user }])

questions_r = Question.create!([{ body: 'Вы знаете Ruby?', test: tests[0] },
                                { body: 'Ruby - ето чьто?', test: tests[0] },
                                { body: 'Какая команда отвечает за вывод?', test: tests[0] },
                                { body: 'Вы эксперт в Ruby?', test: tests[2] },
                                { body: 'Точно?', test: tests[2] }])

questions_s = Question.create!([{ body: 'Что такое сортировка?',
                                  test: tests[1] },
                                { body: 'Есть ли алгоритм сортировки "пузырьком"?',
                                  test: tests[1] },
                                { body: 'Стали бы вы использовать алгоритм сортировки пузырьком на больших данных?',
                                  test: tests[1] },
                                { body: 'Данные можно сжать?',
                                  test: tests[3] },
                                { body: 'Как бы вы сжимали данные?',
                                  test: tests[3] }])

Answer.create!([{ body: 'Да', correct: true, question: questions_r[0] },
                { body: 'Нет', question: questions_r[0] }])

Answer.create!([{ body: 'Язык программирования', correct: true, question: questions_r[1] },
                { body: 'Слово', question: questions_r[1] },
                { body: 'Рубин с английского', question: questions_r[1] }])

Answer.create!([{ body: 'puts', correct: true, question: questions_r[2] },
                { body: 'gets', question: questions_r[2] },
                { body: 'inspect', question: questions_r[2] }])

Answer.create!([{ body: 'Да', correct: true, question: questions_r[3] },
                { body: 'Нет', question: questions_r[3] }])

Answer.create!([{ body: 'Да', correct: true, question: questions_r[4] },
                { body: 'Нет', question: questions_r[4] }])

Answer.create!([{ body: 'Алгоритм упорядочивания данных', correct: true, question: questions_s[0] },
                { body: 'Не знаю', question: questions_s[0] }])

Answer.create!([{ body: 'Да', correct: true, question: questions_s[1] },
                { body: 'Нет', question: questions_s[1] }])

Answer.create!([{ body: 'Нет', correct: true, question: questions_s[2] },
                { body: 'Да', question: questions_s[2] }])

Answer.create!([{ body: 'Да', correct: true, question: questions_s[3] },
                { body: 'нет', question: questions_s[3] }])

Answer.create!([{ body: 'С помощью программ и алгоритмов', correct: true, question: questions_s[4] },
                { body: 'Руками со всей силы', question: questions_s[4] }])

biba = User.create!(email: 'biba@mail.ru', login: 'biba', password: 'qwerty')
boba = User.create!(email: 'boba@mail.ru', login: 'boba', password: 'qwerty')

tests.each do |test|
  questions = test.questions.order(id: :desc)
  current_question_index = rand(questions.count - 1)

  user.test_passages.create!(test: test, 
                             current_question_id: nil, 
                             correct_questions: questions.count)
  biba.test_passages.create!(test: test, 
                             current_question_id: questions[current_question_index].id, 
                             correct_questions: rand(current_question_index))
  
  if [true, false].sample
    current_question_index = rand(questions.count - 1)
    boba.test_passages.create!(test: test, 
                               current_question_id: questions[current_question_index].id, 
                               correct_questions: rand(current_question_index))
  end

  # Badges
  rules = Specifications::Badges::RULES
  Badge.create!(title: "First Try!",
                description: rules[:first_try][:description],
                rule: :first_try,
                image_path: "./")
  
  ruby_category = categories[0]
  Badge.create!(title: "#{ruby_category.title} guru!", 
                description: "#{rules[:passed_all_tests_by_category][:description]} #{ruby_category.title}",
                rule: :passed_all_tests_by_category,
                rule_value: ruby_category.id,
                image_path: "./")
  
  Badge.create!(title: "Guru lvl. 1",
                description: "#{rules[:passed_all_tests_by_level][:description]} 1",
                rule: :passed_all_tests_by_level,
                rule_value: 1,
                image_path: "./")
end