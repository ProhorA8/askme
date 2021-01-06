class TagsController < ApplicationController
  def show
    @tag = Tag.find_by!(name: params[:name])
    @questions = @tag.questions
  end
end
