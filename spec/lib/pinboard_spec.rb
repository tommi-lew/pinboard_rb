require 'spec_helper'

describe 'Pinboard' do
  let(:pb) { Pinboard.new('username', 'password') }

  describe 'API Call' do
    before (:each) do
      stub_request(:any, /api.pinboard.in/)
    end

    it 'should do a HTTP GET to Pinboard without query strings when it has no parameters ' do
      pb.posts.recent.req
      WebMock.should have_requested(:get, "https://username:password@api.pinboard.in/v1/posts/recent?")
    end

    it 'should do a HTTP GET to Pinboard with query strings when it has parameters' do
      pb.posts.recent.params({tag: 'pbrb'}).req
      WebMock.should have_requested(:get, "https://username:password@api.pinboard.in/v1/posts/recent?").
        with(:query => {tag: 'pbrb'})
    end
  end

  describe 'API Calls with errors' do
    before (:each) do
      stub_request(:any, /api.pinboard.in/).to_return(:body => '401 Forbidden')
    end

    it 'should raise an InvalidCredentialsError' do
      lambda { pb.posts.recent.req }.should raise_error Pinboard::InvalidCredentialsError
    end
  end

  describe 'implementation of method missing' do
    it 'should store name of method calls into an array' do
      pb.a.b.c
      calls_array = pb.instance_variable_get(:@calls)
      calls_array.should be_a_kind_of(Array)
      calls_array[0].should == :a
      calls_array[1].should == :b
      calls_array[2].should == :c
    end

    context 'when .params method is invoked' do
      it 'should not store a .params method call into the array' do
        pb.a.params
        calls_array = pb.instance_variable_get(:@calls)
        calls_array.size.should == 1
        calls_array[0].should == :a
      end

      it 'should not store a .clear method call into the array' do
        pb.a.clear
        calls_array = pb.instance_variable_get(:@calls)
        calls_array.size.should == 0
      end
    end
  end

  describe 'able to clear the earlier method calls' do
    it 'should reset array to empty' do
      pb.a.b
      calls_array = pb.instance_variable_get(:@calls)
      calls_array.size.should == 2
      pb.clear
      calls_array = pb.instance_variable_get(:@calls)
      calls_array.should be_empty
    end
  end

end
