

    if params[:date_selected].class != NilClass
      @date_selected = params[:date_selected].to_date
      @day_of_week_selected = @date_selected.strftime ('%w') 
        # Sunday = 0, Monday = 1, etc.

        @locations_selected = params[:locations_selected]

        if @locations_selected[0] === "All boroughs"
          @locations_selected = @boroughs
        end

        @categories_selected = params[:categories_selected]
        if @categories_selected[0] != "All"
          @categories = @categories.where(:name => @categories_selected)
        end
    end