class Api::BillsController < Api::BaseController
  before_action :set_bill, only: %i(show update destroy)
  before_action :confirm_bill_ownership, only: %i(update destroy)
  before_action :parse_date, only: %i(create update)

  def index
    render json: current_user.bills_including_split
  end

  def create
    @bill = current_user.bills.build(bill_params)
    render json: @bill, status: 201 and return if @bill.save

    render json: @bill.errors.full_messages, status: 400
  end

  def show
    render json: @bill, status: 200
  end

  def update
    @bill.update(bill_params)
    render json: @bill, status: 200
  end

  def destroy
    @bill.destroy
    render json: { message: 'Bill deleted successfully' }, status: 200
  end

  private

  def set_bill
    @bill = current_user.bills_including_split.find_by(id: params[:id])
    render_with_not_found('Bill') unless @bill
  end

  def confirm_bill_ownership
    return if @bill && @bill.creator == current_user
    render_with_unauthorized('bill')
  end

  def bill_params
    params.permit(:amount, :title, :description, :date, splitters: [])
  end

  def parse_date
    bill_params[:date] = DateTime.parse(bill_params[:date].to_s)
  rescue ArgumentError
    nil
  end
end
