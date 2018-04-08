class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
    can [:create, :edit, :update, :destroy, :complete], Task, todo_list: { user_id: user.id }
    can [:sort_by_due_date, :sort_by_title, :sort_by_custom, :reorder, :show_completed_toggle], Task

    can [:create, :update], Note, user_id: user.id
    can [:show_notes_toggle], Note

    can [:update], Timer, user_id: user.id

    # can do any action to a todo_list that the user owns apart from view the show page
    can [:index, :new, :create, :edit, :update, :destroy], TodoList, user_id: user.id

    # can manage any module that the user owns
    can :manage, LectureModule, user_id: user.id
    # anyone can read lecture modules
    can :read, LectureModule

    # can do any action to content belonging to a module that user owns apart from view the show page
    # TODO for some reason this still lets me add content to a module that I don't own
    can [:new, :create, :edit, :update, :destroy], LectureModuleContent do |content|
      !LectureModule.find_by(user_id: user.id, id: content.week.lecture_module_id).nil?
    end

    can [:read, :new, :create], Comment do |comment|
      !UserModuleLinker.find_by(user_id: user.id, lecture_module_id: comment.week.lecture_module_id).nil?
    end
    can [:update, :destroy], Comment, user_id: user.id
    can [:show_comments_toggle], Comment

  end
end
