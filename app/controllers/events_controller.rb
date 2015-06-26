class EventsController < ApplicationController
  before_filter :shared_content, :only => [:new, :edit, :display, :copy]
  before_filter :common_content, :only => [:edit, :show, :update, :destroy]

  def shared_content
    @boroughs = ["Manhattan", "Brooklyn", "Queens", "the Bronx", "Staten Island"]
    @notes = ["  ", 
      "Gates open at 6. Bandshell, 9th St. & Prospect Park West.",
      "Gates open at 6:30. Bandshell, 9th St. & Prospect Park West.",
      "Gates open at 3. Bandshell, 9th St. & Prospect Park West.",
      "Gates open at 7. Bandshell, 9th St. & Prospect Park West.",
      "Great Lawn, mid-park between 79th and 85th Streets.",
      "Pier 1: enter the park at Riverside and W. 68th St.",
      "Cedar Hill: 5th Ave. & E. 79th St.",
      "Lessons from 6 - 7 pm, followed by dancing to live music 7 - 8:30 pm.",
      "Screening is outdoors on the library steps.",
      "Tickets required, see event website",
      "Movie showing is at the touchdown of the 103rd St. Footbridge.",
      "Doors open 1 hour before show.",
      "Closed on legal holidays.",
      "Movie begins at sunset.", 
      "Live music and food trucks at 6. Movie begins at sundown.",
      "Music starts at 6 pm, movies at sunset.",
      "Gates open at 6:30 pm.",
      "Gates open at 6:30. No chairs. Located on the landscape between Sheep Meadow and the 72nd Street Cross Drive.",
      "Gates open at 6 pm.",
      "Gates open at 7 pm.",
      "The Sculpture Garden opens at 7 pm. In the event of rain, concerts will be held in the Gund Garden Lobby.",
      "Doors open at 7:30. Seating is very limited, so arrive early.",
      "Doors open at 6:30.",
      "Gates open at 3 pm.",
      "Free film tickets are available after 4pm.",
      "Line forms at 5:30 and tickets are distributed at 6, 1 ticket/person.",
      "Line forms at 5 and tickets are distributed at 5:30, 1 ticket/person.",
      "Pre-screening performances at 7 pm; films begin at sundown.",
      "Outdoors; 3,100 seats - first-come, first-served.",
      "Outdoor screenings of operas; 3,100 seats - first come, first-served.",
      "Films begin at dusk and are open-captioned.",
      "W. 72nd Track & Lawn in Riverside Park. Ground seating 1-2 hours before event.",
      "Approx. 250 chairs plus ground seating.",
      "Doors open at 7pm.",
      "Seating begins at 6:30 on Friday, 7 all other days.",
      "At the Elinor Bunin Munroe Film Center.",
      "Admission is pay as you wish.",
      "Admission is pay as you wish from 5:45 - 7:15 pm. The museum closes at 7:45.",
      "Admission is pay as you wish from 11 - 1. The museum closes at 5 pm.",
      "Admission is pay as you wish from 7 - 9:30 pm. The museum closes at 10.",
      "Admission is pay as you wish from 4-5 pm. The aquarium closes at 6.",
      "During UNIQLO Free Friday Nights, film tickets are free from 4:00 to 8:00 p.m.",
      "Tickets include access to galleries, exhibitions and films. Closed on Christmas.",
      "Closed on Friday, December 25, 2015.",
      "Closed on Thanksgiving and Christmas Day.",
      "Closed July 4, Thanksgiving and Christmas Day.",
      "Closed Thanksgiving, Christmas and New Year's Day.",
      "Closed on all major holidays.",
      "Free only for those 65 and older, with proof of age if requested.",
      "Free grounds-only admission.",
      "Free grounds-only admission from 9 - 10 am; the grounds close at 6 pm.",
      "No free admission on Saturdays with public programs -Sakura Matsuri, Ghouls & Gourds, etc.",
      "Free hours are suspended during the World Maker Faire.",
      "RSVPs encouraged - see event website.",
      "RSVP required - see event website.",
      "Free ticket distribution begins at 4 pm (please check - time is subject to change)."]
  end

  def common_content
    @event = Event.find(params[:id])
  end

  def index
    @events = Event.all
  end

  def display
    @categories = Category.joins(:events).uniq
    @categories_to_choose_from = ["All"]
    x = 0
      while x < @categories.size
        @categories_to_choose_from << @categories[x].name
        x = x+1
      end

    @locations = ["All boroughs", "Manhattan", "Brooklyn", "Queens", "the Bronx", "Staten Island"]
    @default_locations_selected = []
      if params[:locations_selected].class == Array
        @default_locations_selected = params[:locations_selected]
      else @default_locations_selected = @locations[0]
      end
    @default_categories_selected = []
      if params[:categories_selected].class == Array
        @default_categories_selected = params[:categories_selected]
      else @default_categories_selected = @categories_to_choose_from[0]
      end
    @date_range = []

    i = 0
      while i <= 90
        date_label_pair = []
        if i === 0
          date_label_pair << "Today"
        elsif i === 1
          date_label_pair << "Tomorrow"
        else
          date_label_pair << (Date.today+i).strftime("%A, %b %-d")
        end
        date_label_pair << Date.today+i
        @date_range << date_label_pair
        i = i+1
      end

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
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])

    if @event.save
        redirect_to @event, notice: "Event created successfully."
    else
        render "new", notice: "Error creating event."
    end
  end

  def edit
  end

  def show
  end

  def update
    if @event.update_attributes(params[:event])
      redirect_to @event, notice: 'Event updated successfully.'
    else
      render "edit", notice: "Error updating event."
      end
  end

  def copy
    @source = Event.find(params[:id])
    @event = @source.dup
    render 'new'
  end

  def destroy
    @event.destroy

    redirect_to events_path, notice: 'Event deleted successfully.'
  end

end