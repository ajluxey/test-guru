# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(login: 'ajluxey', password: 'qwerty')
categories = Category.create!([{ title: 'Ruby' }, { title: 'Алгоритмы' }])
tests = Test.create!([{ title: 'Основы Ruby', category_id: categories[0].id, author_id: user.id },
                      { title: 'Сортировки', level: 2, category_id: categories[1].id, author_id: user.id },
                      { title: 'Ruby - Экспертный тест', level: 10, category_id: categories[0].id, author_id: user.id },
                      { title: 'Алгоритмы сжатия информации', level: 2, category_id: categories[1].id, author_id: user.id }])

questions_r = Question.create!([{ body: 'Вы знаете Ruby?', test_id: tests[0].id },
                                { body: 'Ruby - ето чьто?', test_id: tests[0].id },
                                { body: 'Какая команда отвечает за вывод?', test_id: tests[0].id },
                                { body: 'Вы эксперт в Ruby?', test_id: tests[2].id },
                                { body: 'Точно?', test_id: tests[2].id }])

questions_s = Question.create!([{ body: 'Что такое сортировка?',
                                  test_id: tests[1].id },
                                { body: 'Есть ли алгоритм сортировки "пузырьком"?',
                                  test_id: tests[1].id },
                                { body: 'Стали бы вы использовать алгоритм сортировки пузырьком на больших данных?',
                                  test_id: tests[1].id },
                                { body: 'Данные можно сжать?',
                                  test_id: tests[3].id },
                                { body: 'Как бы вы сжимали данные?',
                                  test_id: tests[3].id }])

Answer.create!([{ body: 'Да', correct: true, question_id: questions_r[0].id },
                { body: 'Нет', question_id: questions_r[0].id }])

Answer.create!([{ body: 'Язык программирования', correct: true, question_id: questions_r[1].id },
                { body: 'Слово', question_id: questions_r[1].id },
                { body: 'Рубин с английского', question_id: questions_r[1].id }])

Answer.create!([{ body: 'puts', correct: true, question_id: questions_r[2].id },
                { body: 'gets', question_id: questions_r[2].id },
                { body: 'inspect', question_id: questions_r[2].id }])

Answer.create!([{ body: 'Да', correct: true, question_id: questions_r[3].id },
                { body: 'Нет', question_id: questions_r[3].id }])

Answer.create!([{ body: 'Да', correct: true, question_id: questions_r[4].id },
                { body: 'Нет', question_id: questions_r[4].id }])

Answer.create!([{ body: 'Алгоритм упорядочивания данных', correct: true, question_id: questions_s[0].id },
                { body: 'Не знаю', question_id: questions_s[0].id }])

Answer.create!([{ body: 'Да', correct: true, question_id: questions_s[1].id },
                { body: 'Нет', question_id: questions_s[1].id }])

Answer.create!([{ body: 'Нет', correct: true, question_id: questions_s[2].id },
                { body: 'Да', question_id: questions_s[2].id }])

Answer.create!([{ body: 'Да', correct: true, question_id: questions_s[3].id },
                { body: 'нет', question_id: questions_s[3].id }])

Answer.create!([{ body: 'С помощью программ и алгоритмов', correct: true, question_id: questions_s[4].id },
                { body: 'Руками со всей силы', question_id: questions_s[4].id }])

biba = User.create!(login: 'biba', password: 'qwerty')
boba = User.create!(login: 'boba', password: 'qwerty')

tests.each do |test|
  user.tests << test
  biba.tests << test
  # UserStartTest.create!(user_id: user.id, test_id: test.id, passed: true)
  # UserStartTest.create!(user_id: biba.id, test_id: test.id, passed: [true, false].sample)
end

tests.sample(2).each do |test|
  boba.tests << test
  # UserStartTest.create!(user_id: boba.id, test_id: test.id, passed: [true, false].sample)
end
