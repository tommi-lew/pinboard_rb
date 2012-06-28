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
        before { stub_request(:any, /api.pinboard.in/).to_return(:status => [401, "Forbidden"], :body => "401 Forbidden") }

        it 'should raise an InvalidCredentialsError' do
          expect { subject.posts.recent.req }.should raise_error Pinboard::InvalidCredentialsError
        end
      end

      describe 'when there are too many requests' do
        before { stub_request(:any, /api.pinboard.in/).to_return(:status => [429, "Too Many Requests"], :body => '429 Too Many Requests.  Wait 30 seconds before fetching posts/recent again.') }

        it 'should raise a TooManyRequestsError' do
          expect { subject.posts.recent.req }.should raise_error Pinboard::TooManyRequestsError
        end
      end
    end
  end

  describe '#req' do
    context 'when calls array is empty' do
      it 'should raise a UnableToRenderURIError' do
        expect { subject.req }.should raise_error Pinboard::UnableToRenderURIError
      end
    end
  end

  describe 'implementation of method missing' do
    let(:calls) { subject.instance_variable_get(:@calls) }

    it 'should store name of method calls into an array' do
      subject.posts.recent.delete
      calls.should be_a_kind_of(Array)
      calls.should == [:posts, :recent, :delete]
    end

    it 'should only store name of method calls from the white list' do
      expect { subject.a }.to change { calls.size }.by(0)
      expect { subject.posts.update }.to change { calls.size }.by(2)
    end

    context 'when .params method is invoked' do
      it 'should not store a .params method call into the array' do
        subject.a
        expect { subject.params }.to change { calls.size }.by(0)
      end
    end
  end

  describe '.clear' do
    it 'should reset array to empty' do
      subject.posts.recent
      expect { subject.clear }.to change{ subject.instance_variable_get(:@calls).size}.from(2).to(0)
    end
  end
end
