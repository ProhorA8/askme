module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def question_declension(question_count)
    declension(question_count, 'вопрос', 'вопроса', 'вопросов')
  end

  def declension(number, text1, text2, text3)
    second_last_digit = (number / 10) % 10
    exclusions = (second_last_digit == 1)

    last_number = number % 10

    return text3 if last_number.zero? || last_number.between?(5, 9) || exclusions
    return text2 if last_number.between?(2, 4)

    text1
  end
end
