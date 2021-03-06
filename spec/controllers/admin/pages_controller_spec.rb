require 'spec_helper'

describe Admin::PagesController do
  before do
    @blog = Factory(:blog)
    request.session = { :user => users(:tobi).id }
  end

  describe '#index' do
    it 'should response success' do
      get :index
      response.should be_success
      assert_template 'index'
      assert_not_nil assigns(:pages)
    end

    it 'should response success with :page args' do
      get :index, :page => 1
      response.should be_success
      assert_template 'index'
      assert_not_nil assigns(:pages)
    end

  end

  it "test_show" do
    page = Factory(:page)
    get :show, :id => page.id
    assert_response :success
    assert_template "show"
    assert_not_nil assigns(:page)
    assert_equal page, assigns(:page)
  end

  it "test_new" do
    get :new
    assert_response :success
    assert_template "new"
    assert_not_nil assigns(:page)

    assert_equal users(:tobi), assigns(:page).user
    assert_equal TextFilter.find_by_name(@blog.text_filter), assigns(:page).text_filter

    post :new, :page => { :name => "new_page", :title => "New Page Title",
      :body => "Emphasis _mine_, arguments *strong*" }

    new_page = Page.find(:first, :order => "id DESC")

    assert_equal "new_page", new_page.name

    assert_response :redirect, :action => "show", :id => new_page.id

    # XXX: The flash is currently being made available improperly to tests (scoop)
    #assert_equal "Page was successfully created.", flash[:notice]
  end

  it "test_edit" do
    page = Factory(:page)
    get :edit, :id => page.id
    assert_response :success
    assert_template "edit"
    assert_not_nil assigns(:page)

    assert_equal page, assigns(:page)

    post :edit, :id => page.id, :page => { :name => "markdown-page", :title => "Markdown Page",
        :body => "Adding a [link](http://www.typosphere.org/) here" }

    assert_response :redirect, :action => "show", :id => page.id

    # XXX: The flash is currently being made available improperly to tests (scoop)
    #assert_equal "Page was successfully updated.", flash[:notice]
  end

  it "test_destroy" do
    page = Factory(:page)
    post :destroy, :id => page.id
    assert_response :redirect, :action => "list"
    assert_raise(ActiveRecord::RecordNotFound) { Page.find(page.id) }
  end
end
