class Api::BillsController < Api::BaseController
  def index
    render json: current_user.bills
  end

  def create
    @bill = current_user.bills.build(bill_params)
    render json: @bill, status: 201 and return if @bill.save

    render json: @bill.errors.full_messages, status: 400
  end

  def show
  end

  def update
  end

  def delete
  end

  private

  def bill_params
    params.permit(:amount, :title, :description, :date, splitters: [])
  end
end
