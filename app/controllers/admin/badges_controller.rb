module Admin
  class BadgesController < ::Admin::Base
    include ::Controllers::Search::Support
    require 'csv'
    after_filter :set_content_type

    Person = Struct.new(:first_name, :last_name, :company, :diner, :speaker)
    Byer = Struct.new(:diner, :place, :company, :name)

    def set_content_type
      headers["Content-Type"] = "image/svg+xml"
    end

    def show
      # build byuer list to discount places and diner later
      @byers = Hash.new
      Registration.all().each do |r|
        byer = Byer.new(0, 0, "", "")
        if !r.invoice.user.nil?
          byer.name = r.invoice.user.last_name
          byer.company = r.invoice.user.company.name unless r.invoice.user.company.nil?
          if r.product.ref == "diner"
            diner = 0
            if !@byers[r.invoice.user.email].nil? && !@byers[r.invoice.user.email].diner.nil?
              diner = @byers[r.invoice.user.email].diner
            end
            byer.diner = diner + 1
          else
            place = 0
            if !@byers[r.invoice.user.email].nil? && !@byers[r.invoice.user.email].place.nil?
              place = @byers[r.invoice.user.email].place
            end
            byer.place = place + 1
          end
          @byers[r.invoice.user.email] = byer
        end
      end

      # build registered users list
      allRegistrations = Registration.all()

      @users = Hash.new
      allRegistrations.each do |r|
        person = Person.new("", "", "", false, false)
        email = nil
        if !r.user.nil?
          email = r.user.email
          person.first_name = r.user.first_name
          person.last_name = r.user.last_name
          person.company = r.user.company.name unless r.user.company.nil?
        end
        if r.product.ref == "diner"
          person.diner = true
        end
        if !email.nil?
          insert = false
          if @users[email].nil?
            insert = true
          elsif @users[email].diner != true
            insert = true
          end
          if insert == true
            buyer = @byers[r.invoice.user.email]
            if r.product.ref == "diner"
              if !r.invoice.user.nil? && !@byers[r.invoice.user.email].nil?
                buyer.diner = buyer.diner - 1
              end
            else
              if !r.invoice.user.nil? && !@byers[r.invoice.user.email].nil?
                buyer.place = buyer.place - 1
                @byers[r.invoice.user.email] = buyer
              end
            end
            @byers[r.invoice.user.email] = buyer
            logger.info "p: #{@byers[r.invoice.user.email].place} d:#{@byers[r.invoice.user.email].diner} #{@byers[r.invoice.user.email].name}"
            @users[email] = person
          end
        end
      end

      # add speakers
      speakers = CSV.parse(File.read("db/csv/#{Rails.env}/speakers.csv"))
      speakers.each do |s|
        if !@users[s[2]].nil?
          person = @users[s[2]]
        else
          person = Person.new(s[0], s[1], "", true, true)
        end
        person.speaker = true
        @users[s[2]] = person
      end

      logger.info "Found #{@users.length()} with registration."
      logger.info "Found #{@byers.length()} with registration."
      logger.info @byers

      # add missing registrations
      @badges = @users.values
      @byers.values.each do |b|
        place = b.place
        diner = b.diner
        place = place - diner
        for i in 1..place
          person = Person.new("", "", "#{b.company} (#{b.name})", false, false)
          @badges.push(person)
          logger.info "push a place because of p:#{b.place} d:#{b.diner} #{b.name}"
        end
        for i in 1..diner
          person = Person.new("", "", "#{b.company} (#{b.name})", true, false)
          @badges.push(person)
          logger.info "push a diner because of p:#{b.place} d:#{b.diner} #{b.name}"
        end
      end

      logger.info "#{@badges.length()}"

      respond_to do |format|
        format.svg  { render @badges => "show.svg.erb", :layout => false }
      end
      # Ruh-roh!
    end
  end
end

