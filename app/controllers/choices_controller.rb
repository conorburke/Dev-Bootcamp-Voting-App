class ChoicesController < ApplicationController
  def create
    ideas = params[:preference]
    ideas.each_with_index do |idea,index|
      idea_i = Idea.find_by_id(idea.to_i)
      idea_i.choices.create(student_id: current_user.id, preference_level: index + 1)
    end
    redirect_to ideas_path
  end
end
