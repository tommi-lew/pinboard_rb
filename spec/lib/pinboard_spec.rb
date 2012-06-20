require 'spec_helper.rb'

describe 'Pinboard' do
  describe 'API Call'do
    it 'should call initiate and HTTP GET to Pinboard' do
      Pinboard.should_receive(:get).and_return("done!")
      pb = Pinboard.new('username', 'password')
      pb.posts.recent.get
    end
  end
end
