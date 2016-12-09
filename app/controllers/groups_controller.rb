class GroupsController < ApplicationController
  def index
    @cohort = Cohort.find_by_id(params[:cohort_id])
    @groups = @cohort.groups
  end

  # def create
  #   p request
  #   redirect_to groups_path
  # end

  def update
    puts "==================="
    keys = params[:groupObj].keys
    keys.each do |group_id|
      group = Group.find_by_id(group_id.to_i)
      students = params[:groupObj][group_id]
      students.each do |student_id|
        student = Student.find_by_id(student_id.to_i)
        student.group = group
        student.save
      end
    end
    @cohort = Cohort.find_by_id(params[:cohort_id])
    @cohort.next_phase
    if request.xhr?
      "done"
    else
      redirect_to cohort_groups_path(@cohort)
    end
  end

end
