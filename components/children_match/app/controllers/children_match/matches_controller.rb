require_dependency "children_match/application_controller"

module ChildrenMatch
  class MatchesController < ApplicationController
    before_action :set_match, only: [:show, :edit, :update, :destroy]

    if Rails.env.match(/production/)
      before_action :invoke_wx_auth , if: Proc.new { |c| c.request.format != 'application/json' && !c.request.local? }
      before_action :get_wechat_sns , if: Proc.new { |c| c.request.format != 'application/json' && !c.request.local? }
    end

    before_action :authenticate, except: [:show, :index]
    skip_before_action :authenticate, only: [:create], if: Proc.new { |c| c.request.format == 'application/json'}

    # GET /matches
    # GET /matches.json
    def index
      if Rails.env.match(/production/)
        @openid_results = ChildrenMatch::Match.includes(:form).where(openid: session[:openid]).order(id: :desc)
      else
        @openid_results = ChildrenMatch::Match.includes(:form).order(id: :desc)
      end

      @have_prize

    end

    # GET /matches/1
    # GET /matches/1.json
    def show
    end

    # GET /matches/new
    def new
      @match = ChildrenMatch::Match.new
    end

    # GET /matches/1/edit
    def edit
    end

    # POST /matches
    # POST /matches.json
    def create
      # like: http://localhost:3000/results?pass=ENV["QIANYAN_FORM_PASS"]
      unless params[:pass] == ENV["QIANYAN_PASS"]
        return render json: {'fail':'need pass'}.to_json, status: :bad_request
      end

      id = match_params.dig(:entry, :serial_number) ||  match_params[:id]

      form_params = {form: params["form"], form_name: params["form_name"]}
      @form = ChildrenMatch::Form.find_or_create_by(form: form_params[:form])
      @form.assign_attributes(form_params)
      @form.save

      hash = {
        "id" => id,
        "form_id" => @form.id,
        "serial_number" => match_params.dig(:entry, :serial_number) ||  match_params[:id],
        "openid" => match_params.dig(:entry, :x_field_weixin_openid) || match_params[:openid],
        # "phone" => match_params.dig(:entry, :phone) || match_params[:phone],
        # "email" => match_params.dig(:entry, :email) || match_params[:email],
        "gen_code" => match_params.dig(:entry, :gen_code) || match_params[:gen_code] || "",
        # "created_at" => match_params.dig(:entry, :created_at) || match_params[:created_at],
        # "updated_at" => match_params.dig(:entry, :updated_at) || match_params[:updated_at]
      }
      # byebug
      match_params_merged = match_params.merge(hash)

      @match = ChildrenMatch::Match.find_or_create_by(id: id)
      @match.assign_attributes(match_params_merged)

      respond_to do |format|
        if @match.save
          format.html { redirect_to @match, notice: 'Match was successfully created.' }
          format.json { render json: "", status: :ok }
          # format.json { render :show, status: :created, location: @match }
        else
          format.html { render :new }
          format.json { render json: @match.errors, status: :unprocessable_entity }
        end
      end
    end

    def batch_create

    end

    # PATCH/PUT /matches/1
    # PATCH/PUT /matches/1.json
    def update
      respond_to do |format|
        if @match.update(match_params)
          format.html { redirect_to @match, notice: 'Match was successfully updated.' }
          format.json { render :show, status: :ok, location: @match }
        else
          format.html { render :edit }
          format.json { render json: @match.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /matches/1
    # DELETE /matches/1.json
    def destroy
      @match.destroy
      respond_to do |format|
        format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_match
        @match = ChildrenMatch::Match.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def match_params
        params.fetch(:match, {}).permit(:id, :serial_number, :form, :form_name, :openid, :gen_code, :created_at, :updated_at, :entry => {})
      end
  end
end
