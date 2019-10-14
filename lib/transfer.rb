require 'pry'

class Transfer
  
  @@transfer_amounts = []
  
  attr_accessor :amount, :status
  attr_reader :sender, :receiver

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
    # binding.pry
  end
  
  def valid? 
    @sender.valid? && @receiver.valid?
  end
  
  def execute_transaction
    @@transfer_amounts << @amount
    if valid? && @sender.balance > @amount
      @receiver.balance += @amount
      @sender.balance -= @amount
      @status = "complete"
      @amount -= @amount
    else
      @status = 'rejected'
      "Transaction rejected. Please check your account balance."
    end
    # binding.pry
  end
  
  def reverse_transfer 
    if @status == 'complete'
      @sender.balance += @@transfer_amounts[-1]
      @receiver.balance -= @@transfer_amounts[-1]
      @status = "reversed"
    end
    # binding.pry
  end
  
  def self.transfers
    @@transfer_amounts
    # binding.pry
  end
end








