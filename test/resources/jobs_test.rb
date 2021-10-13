# frozen_string_literal: true

require 'test_helper'

class JobsResourceTest < Minitest::Test
  def test_list
    stub = stub_request('jobs', response: stub_response(fixture: 'jobs/list'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    jobs = client.jobs.list

    assert_equal SmartRecruiters::Collection, jobs.class
    assert_equal SmartRecruiters::Job, jobs.content.first.class
    assert_equal 'New job', jobs.content.first.title
  end

  def test_retrieve
    job_id = '3588f6b0-ae55-4c10-aaa5-2903ee3a7fe6'
    stub = stub_request("jobs/#{job_id}", response: stub_response(fixture: 'jobs/retrieve'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    job = client.jobs.retrieve(job_id: job_id)

    assert_equal SmartRecruiters::Job, job.class
    assert_equal 'Retrieve job', job.title
  end

  def test_list_hiring_team
    job_id = '3588f6b0-ae55-4c10-aaa5-2903ee3a7fe6'
    stub = stub_request("jobs/#{job_id}/hiring-team", response: stub_response(fixture: 'jobs/list_hiring_team'))
    client = SmartRecruiters::Client.new(api_key: 'fake', adapter: :test, stubs: stub)
    team = client.jobs.list_hiring_team(job_id: job_id)

    assert_equal SmartRecruiters::Collection, team.class
    assert_equal SmartRecruiters::Object, team.content.first.class
    assert_equal '174e1674-0793-4632-8b8c-917447f35b31', team.content.first.id
  end
end
