# frozen_string_literal: true

require 'smartrecruiters/version'

module SmartRecruiters
  autoload :Client, 'smartrecruiters/client'
  autoload :Collection, 'smartrecruiters/collection'
  autoload :Error, 'smartrecruiters/error'
  autoload :Object, 'smartrecruiters/object'
  autoload :Resource, 'smartrecruiters/resource'

  autoload :AccessGroup, 'smartrecruiters/objects/access_group'
  autoload :Attachment, 'smartrecruiters/objects/attachment'
  autoload :CallbacksLog, 'smartrecruiters/objects/callbacks_log'
  autoload :Candidate, 'smartrecruiters/objects/candidate'
  autoload :Department, 'smartrecruiters/objects/department'
  autoload :Interview, 'smartrecruiters/objects/interview'
  autoload :Job, 'smartrecruiters/objects/job'
  autoload :Offer, 'smartrecruiters/objects/offer'
  autoload :Posting, 'smartrecruiters/objects/posting'
  autoload :Report, 'smartrecruiters/objects/report'
  autoload :ReportFile, 'smartrecruiters/objects/report_file'
  autoload :Review, 'smartrecruiters/objects/review'
  autoload :SystemRole, 'smartrecruiters/objects/system_role'
  autoload :User, 'smartrecruiters/objects/user'
  autoload :Webhook, 'smartrecruiters/objects/webhook'

  autoload :AccessGroupsResource, 'smartrecruiters/resources/access_groups'
  autoload :CandidatesResource, 'smartrecruiters/resources/candidates'
  autoload :InterviewsResource, 'smartrecruiters/resources/interviews'
  autoload :InterviewTypesResource, 'smartrecruiters/resources/interview_types'
  autoload :JobsResource, 'smartrecruiters/resources/jobs'
  autoload :OffersResource, 'smartrecruiters/resources/offers'
  autoload :PostingsResource, 'smartrecruiters/resources/postings'
  autoload :ReportsResource, 'smartrecruiters/resources/reports'
  autoload :ReviewsResource, 'smartrecruiters/resources/reviews'
  autoload :SystemRolesResource, 'smartrecruiters/resources/system_roles'
  autoload :UsersResource, 'smartrecruiters/resources/users'
  autoload :WebhooksResource, 'smartrecruiters/resources/webhooks'
end
