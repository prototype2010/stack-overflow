import 'jquery'

$('form.upvote, form.downvote, form.destroy').on('ajax:success', function (e) {
	const {detail} = e
	const [response] = detail

	const {action,count,parent_class,parent_id,} = response;

	const valueNode = $(`#${parent_class.toLowerCase()}_votes_count_${parent_id}`)

	valueNode.html(count)

	const upvote = $(`form[name="${parent_class.toLowerCase()}_upvote_${parent_id}"]`)
	const downvote = $(`form[name="${parent_class.toLowerCase()}_downvote_${parent_id}"]`)
	const destroy = $(`form[name="${parent_class.toLowerCase()}_destroy_${parent_id}"]`)

	switch (action) {
		case 'upvote' : {
			upvote.hide()
			downvote.show()
			destroy.show()
			return
		}
		case 'downvote' : {
			upvote.show()
			downvote.hide()
			destroy.show()
			return
		}
		case 'destroy' : {
			upvote.show()
			downvote.show()
			destroy.hide()
			return
		}

	}

})
