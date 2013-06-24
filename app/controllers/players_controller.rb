class PlayersController < ApplicationController
  # GET /players
  # GET /players.json
  def index
    if params[:term]
      like  = "%".concat(params[:term].concat("%"))
      @players = Player.where("name like ?", like)
    else
      @players = Player.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { 
        list = @players.map { |p| Hash[ id: p.id, label: p.name, name: p.name ]} 
        render json: list 
      }
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @player }
    end
  end

  # GET /players/new
  # GET /players/new.json
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @player }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.json
  def create
    @tournament = Tournament.find(params[:player][:tournaments])
    # @player = Player.new(params[:player])

    # CREATE OF FIND????
    # @player = Player.find_or_instantiator_by_attributes(:name => params[:player][:name])
    @player = Player.find_or_create_by_name(params[:player][:name])

    @tournament.players << @player

    respond_to do |format|
      if @player.save
        format.html { redirect_to @tournament, notice: 'Player was successfully created.' }
        format.json { render json: @player, status: :created, location: @player }
      else
        format.html { render action: "new" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.json
  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end
end
