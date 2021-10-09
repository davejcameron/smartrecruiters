require 'smartrecruiters/version'

module SmartRecruiters
  autoload :Client, 'smartrecruiters/client'
  autoload :Collection, 'smartrecruiters/collection'
  autoload :Error, 'smartrecruiters/error'
  autoload :Object, 'smartrecruiters/object'
  autoload :Resource, 'smartrecruiters/resource'

  autoload :AccessGroup, 'smartrecruiters/objects/access_group'
  autoload :Attachment, 'smartrecruiters/objects/attachment'
  autoload :Candidate, 'smartrecruiters/objects/candidate'
  autoload :Interview, 'smartrecruiters/objects/interview'

  autoload :Job, 'smartrecruiters/objects/job'
  autoload :Offer, 'smartrecruiters/objects/offer'
  autoload :User, 'smartrecruiters/objects/user'
  autoload :Report, 'smartrecruiters/objects/report'
  autoload :Review, 'smartrecruiters/objects/review'
  autoload :SystemRole, 'smartrecruiters/objects/system_role'

  autoload :AccessGroupsResource, 'smartrecruiters/resources/access_groups'
  autoload :CandidatesResource, 'smartrecruiters/resources/candidates'
  autoload :InterviewsResource, 'smartrecruiters/resources/interviews'
  autoload :InterviewTypesResource, 'smartrecruiters/resources/interview_types'
  autoload :OffersResource, 'smartrecruiters/resources/offers'
  autoload :JobsResource, 'smartrecruiters/resources/jobs'
  autoload :UsersResource, 'smartrecruiters/resources/users'
  autoload :ReportsResource, 'smartrecruiters/resources/reports'
  autoload :ReviewsResource, 'smartrecruiters/resources/reviews'
  autoload :SystemRolesResource, 'smartrecruiters/resources/system_roles'
end
