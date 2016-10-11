include Facebook::Messenger

Bot.on :message do |m|
 Bot.deliver(
	recipient: m.sender,
	messenger: {
	  text: 'hi man' 
	}
	)
end

