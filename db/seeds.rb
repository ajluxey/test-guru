# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(login: 'ajluxey', password: 'qwerty')
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

biba = User.create!(login: 'biba', password: 'qwerty')
boba = User.create!(login: 'boba', password: 'qwerty')

tests.each do |test|
  user.started_tests << test
  biba.started_tests << test
  # UserStartTest.create!(user_id: user.id, test_id: test.id, passed: true)
  # UserStartTest.create!(user_id: biba.id, test_id: test.id, passed: [true, false].sample)
end

tests.sample(2).each do |test|
  boba.started_tests << test
  # UserStartTest.create!(user_id: boba.id, test_id: test.id, passed: [true, false].sample)
end
