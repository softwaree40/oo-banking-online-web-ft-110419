class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def has_enough_funds?(person)
    person.balance >= self.amount
  end

  def execute_transaction
    if self.status != "complete"
      if self.valid? && self.has_enough_funds?(self.sender) && self.has_enough_funds?(self.receiver)
        self.sender.withdraw(self.amount)
        self.receiver.deposit(self.amount)
        self.status = "complete"
      else

        self.status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    end
  end

  def reverse_transfer
    if self.status == "complete"
      self.receiver.withdraw(self.amount)
      self.sender.deposit(self.amount)
      self.status = "reversed"
    end
  end
end
