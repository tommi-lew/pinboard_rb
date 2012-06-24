require 'spec_helper'
require 'rspec/mocks'

describe 'Pinboard' do
  let(:pb) { Pinboard.new('username', 'password') }
  subject { pb }

  describe 'API Calls' do
    context 'without errors' do
      before { stub_request(:any, /api.pinboard.in/) }

      it 'should do a HTTP GET to Pinboard without query strings when it has no parameters ' do
        subject.posts.recent.req
        WebMock.should have_requested(:get, "https://username:password@api.pinboard.in/v1/posts/recent?")
      end

      it 'should do a HTTP GET to Pinboard with query strings when it has parameters' do
        subject.posts.recent.params({ tag: 'pbrb' }).req
        WebMock.should have_requested(:get, "https://username:password@api.pinboard.in/v1/posts/recent?").
                         with(:query => { tag: 'pbrb' })
      end
    end

    context 'with errors' do
      describe 'when username/password are invalid' do
        before do
          net_res = Net::HTTPResponse.new(1.1, 401, 'Forbidden')
          party_res = double("party_res")
          party_res.stub(:response) { net_res }
          party_res.stub(:headers) { "fuck u"}
          stub_request(:any, /api.pinboard.in/).to_return(party_res)
        end

        it 'should raise an InvalidCredentialsError' do
          lambda { subject.posts.recent.req }.should raise_error Pinboard::InvalidCredentialsError
        end
      end

      describe 'when there are too many requests' do
        before { stub_request(:any, /api.pinboard.in/).to_return(:body => '429 Forbidden') }

        it 'should raise an TooManyRequestError'
      end
    end

    describe 'implementation of method missing' do
      let(:calls) { subject.instance_variable_get(:@calls) }

      it 'should store name of method calls into an array' do
        subject.a.b.c
        calls.should be_a_kind_of(Array)
        calls.should == [:a, :b, :c]
      end

      context 'when .params method is invoked' do
        it 'should not store a .params method call into the array' do
          subject.a
          expect { subject.params }.to change { calls.size }.by(0)
        end
      end
    end

    describe 'able to clear the earlier method calls' do
      it 'should reset array to empty' do
        subject.a.b
        expect { subject.clear }.to change{ subject.instance_variable_get(:@calls).size}.from(2).to(0)
      end
    end
  end

end
