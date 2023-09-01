// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery
//= require activestorage
//= require action_cable
//= require cocoon

import Rails from '@rails/ujs';
import "controllers"
import { GistClient } from "gist-client";
import './votes'

const App = {}
App.cable = ActionCable.createConsumer()

window.GistClient = new GistClient()
window.App = App
Rails.start();

App.cable.subscriptions.create('QuestionsChannel', {
	connected: function () {
		this.perform('follow')
	},
	received: (data) => $('#questions').append(data)
})

App.cable.subscriptions.create('AnswersChannel', {
	connected: function () {
		const questionsPathRegexp = /^\/questions\/(\d*)$/
		const path = window.location.pathname

		if(questionsPathRegexp.test(path)) {
			const [,questionId] = path.match(questionsPathRegexp)

			this.perform('follow', {questionId})
		}
	},
	received: (data) => $('.answers').append(data)
})
