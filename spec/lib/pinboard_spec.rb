require 'spec_helper'

describe 'Pinboard' do
  let(:pb) { Pinboard.new('username', 'password') }

  before (:each) do
    stub_request(:any, /api.pinboard.in/)
  end

  describe 'API Call' do
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
    end
  end

end
