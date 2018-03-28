class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
    can [:create, :edit, :update, :destroy, :complete], Task, todo_list: { user_id: user.id }
    can [:sort_by_due_date, :sort_by_title, :sort_by_custom, :reorder], Task
    can [:create, :update], Note, user_id: user.id
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








    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
