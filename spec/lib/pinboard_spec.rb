require 'spec_helper'

describe 'Pinboard' do
  let(:pb) { Pinboard.new('username', 'password') }

  before (:each) do
    stub_request(:any, /api.pinboard.in/)
  end

  describe 'API Call'do
    it 'should do a HTTP GET to Pinboard without query strings when it has no parameters ' do
      pb.posts.recent.get
      WebMock.should have_requested(:get, "https://username:password@api.pinboard.in/v1/posts/recent?")
    end

    it 'should do a HTTP GET to Pinboard with query strings when it has parameters' do
      pb.posts.recent.params({tag: 'pbrb'}).get
      WebMock.should have_requested(:get, "https://username:password@api.pinboard.in/v1/posts/recent?").
        with(:query => {tag: 'pbrb'})
    end
  end
end
