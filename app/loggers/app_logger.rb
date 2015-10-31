class AppLogger
  def self.log(type, message)
    logger = Logger.new File.new('log/app.log', 'a+')
    logger.send(type, message)

    output = case type
               when :error then '[ERROR] '
               when :info  then '[OK] '
               else             ''
             end
    output += message
    puts output unless $quiet
  end
end
