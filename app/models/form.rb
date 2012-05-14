class Form
  attr_accessor :amount, :payer, :participated, :event

  def initialize(amount, payer, participated, event)
    self.amount = amount.gsub(/[$ ]/,'')
    self.payer = payer
    self.participated = participated
    self.event = event
  end

  def valid?
    validation_errors == []
  end

  def validation_errors
    errors = []
    errors << "No payer specified" unless payer
    errors << "No participants" if participated == []
    errors << "No event specified" if event.nil? || event.strip == ""
    errors << "Invalid amount" unless amount =~ /\A[0-9]+(\.[0-9][0-9])?\z/
    errors
  end

  def url
    url = "https://spreadsheets.google.com/formResponse?formkey=dHpSeWdIaTB6NlViVXhRazVJUXlmMHc6MQ"

    url << "&entry.0.single=#{escape(amount)}"
    url << "&entry.1.single=#{escape(payer.name)}"

    participated.each do |p|
      url << "&entry.2.group=#{escape(p.name)}"
    end

    url << "&entry.3.single=#{escape(event)}"
    url << "&pageNumber=0&backupCache=&submit=Submit"

    $stderr.puts url.inspect
    url = NSURL.alloc.initWithString(url)
    $stderr.puts url.inspect
    if url.nil?
      raise "PASJDKJASKD"
    end
    @url = url
  end

  def escape(str)
    str.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
  end

  # Woohoo! isn't it nice when things just work :).
  def submit!
    NSString.stringWithContentsOfURL(url)
  end
end
