class MatchController < ApplicationController
	def update
    @match = Match.find(params[:id])
    @tournament = @match.tournament

    respond_to do |format|
      # if @match.update_attributes(params[:match])
      if @match.update_score(@match, params[:match])
        format.html { redirect_to @tournament, notice: 'Match was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @tournament, notice: 'error' }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  def finalize_match
		@tournament = Tournament.find(params[:tournament_id])
    @match = Match.find(params[:match])

    if @match.status == "finished"
    	@match.status = "editing"
    else
	    @match.status = "finished"
	  end
    @match.save

    redirect_to @tournament
  end
end
