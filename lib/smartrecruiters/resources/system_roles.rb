module SmartRecruiters
  class SystemRolesResource < Resource
    def list
      Collection.from_response get_request('user-api/v201804/system-roles'), type: SystemRole
    end
  end
end
