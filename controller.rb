class TodosController < ApplicationController
  # GET /todos
  # GET /todos.xml
  def index
    @todos = Todo.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.xml
  def show
    @todo = Todo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.xml
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])
  end

  # POST /todos
  # POST /todos.xml
  def create
    @todo = Todo.new(params[:todo])
    
    respond_to do |format|
      if @todo.valid?
        case params[:status]
        when "commit"
          @todo.save_without_validation
          format.html { redirect_to(@todo) }
          format.xml  { render :xml => @todo, :status => :created, :location => @todo }
        when "back"
          format.html { render :action => :new}
        else
          format.html { render :action => 'confirm' }
          format.xml  { render :xml => @todo, :status => :valid, :location => @todo }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.xml
  def update
    @todo = Todo.find(params[:id])
    @todo.attributes = params[:todo]

    respond_to do |format|
      if @todo.valid?
        case params[:status]
        when "commit"
          @todo.save_without_validation
          format.html { redirect_to(@todo) }
          format.xml  { head :ok }
        when "back"
          format.html { render :action => :edit}
        else
          format.html { render :action => 'confirm' }
          format.xml  { render :xml => @todo, :status => :valid, :location => @todo }
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.xml
  def destroy
    @todo = Todo.find(params[:id])
    
    respond_to do |format|
      case params[:status]
      when "commit"
        @todo.destroy
        format.html { redirect_to(todos_url) }
        format.xml  { head :ok }
      when "back"
        format.html { redirect_to(todos_url) }
      else
        format.html { render :action => 'confirm' }
        format.xml  { render :xml => @todo, :status => :valid, :location => @todo }
      end
    end
  end
end
