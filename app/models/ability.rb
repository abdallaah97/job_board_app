# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
      if user.is_admin?
        can :manage, JobPost
        can :list_job_applications_by_job_post , JobApplication
      else
        can :manage , JobApplication
      end
  end
end
