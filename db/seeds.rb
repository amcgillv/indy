# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Issue.create(
	title: "the third issue of the college hill independent // SPRING 2014",
	date: "2014-02-15",
	document_number: "140213193509-833cc372205128ef837015d95905ba48",
	url_slug: "issue_3_web",
	published: true, 
	scribd: false)

#Article.delete_all

10.times do
	Article.create(
		by: 'tester', 
		body: "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sit amet lacus sed ligula tempor consequat. Ut non nulla non mi hendrerit imperdiet nec et tortor. Donec tempus augue ut pretium rutrum. Duis lacus dui, egestas a fringilla non, aliquam a nisi. Sed ultricies velit nisi, vitae venenatis nulla tempus in. Nullam luctus nunc sed lacus iaculis, in malesuada eros placerat. Duis placerat libero quis dolor lobortis interdum. Nullam placerat arcu eget imperdiet rhoncus. Aenean id mauris quis mi faucibus malesuada. Donec interdum vehicula lacus, eget sodales quam venenatis nec. Morbi id turpis felis. Aliquam venenatis egestas leo id dapibus. Nam vulputate volutpat ligula, ut luctus orci.</p>\r\n\r\n<p>Nullam quis enim nulla. Nullam nec ultricies dolor. Praesent vitae tincidunt libero, in pulvinar tortor. Praesent eget imperdiet turpis. Nam viverra vehicula tortor eu fermentum. Mauris ullamcorper ipsum non tellus posuere convallis. Suspendisse adipiscing laoreet urna. Vestibulum fermentum nisi at tempor aliquam. Curabitur laoreet eleifend tellus, pharetra ornare mi sodales in. Ut tempor, justo sed aliquam congue, mauris lacus ullamcorper odio, eget facilisis mauris risus ut ante. Nulla at ullamcorper dolor. Proin vitae dignissim mauris, ac hendrerit nulla.</p>\r\n\r\n<p>Morbi molestie magna ac diam commodo porttitor. Vestibulum interdum turpis sed eros lacinia fringilla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Duis tortor nunc, gravida ac rhoncus pulvinar, adipiscing id nisl. Nulla enim ante, ultricies a eleifend sit amet, dictum nec enim. Nam nulla libero, mattis quis purus non, dignissim blandit tortor. Pellentesque ultrices felis non libero mollis faucibus. Quisque nisi nisl, mollis nec vehicula et, suscipit quis elit.</p>\r\n\r\n<p>Suspendisse ligula magna, adipiscing quis dictum in, pellentesque at augue. Duis ac congue felis. Curabitur ac lectus vel dolor eleifend venenatis imperdiet interdum arcu. Mauris et enim vel orci accumsan feugiat ac vitae neque. Nunc fringilla neque nulla, in aliquam purus iaculis id. Phasellus sed ipsum quis purus pharetra tempus. Nam nec diam massa. Integer condimentum tellus eget turpis dapibus, eu convallis libero convallis. Sed sollicitudin diam vitae augue porta, quis dapibus libero pretium. Aliquam erat volutpat. Maecenas enim dolor, facilisis vitae elementum dignissim, cursus nec est. Ut laoreet lacus erat, eu porta nibh ultricies in.</p>\r\n\r\n<p>Sed non ligula placerat, interdum elit ac, ullamcorper massa. Phasellus tincidunt bibendum quam, eget malesuada urna adipiscing at. Aenean at mi nibh. Aliquam iaculis dignissim iaculis. Sed volutpat lacus urna, eget faucibus orci mollis et. Vestibulum faucibus nulla non porttitor ultricies. Curabitur rutrum ligula vel nulla vehicula facilisis.</p>\r\n",
		published_at: 2.days.ago,
		published: true
	)
end