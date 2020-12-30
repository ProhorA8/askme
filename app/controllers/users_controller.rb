class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Evgen',
        username: 'prohor',
        avatar_url: 'https://s.gravatar.com/avatar/b2330e4aa6e1f119b95b635ff53384c8?s=80'),
      User.new(id: 2, name: 'Prometheus', username: 'prome')
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Evgen',
      username: 'ProhorA8',
      avatar_url: 'https://s.gravatar.com/avatar/b2330e4aa6e1f119b95b635ff53384c8?s=80'
    )

    @questions = [
      Question.new(text: 'Как дела?', answer: 'хорошо!', created_at: Date.parse('27.03.2021')),
      Question.new(text: 'Что нового?', created_at: Date.parse('27.03.2021'))
    ]

    @questions_count = @questions.count
    @answers_count = @questions.map(&:answer).count
    @unanswered_count = @questions_count - @answers_count

    @new_question = Question.new
  end
end
