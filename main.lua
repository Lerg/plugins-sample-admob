display.setStatusBar(display.HiddenStatusBar)

local json = require('json')
local widget = require('widget')
local admob = require('plugin.admob')

display.setDefault('background', 1)

local xl, xr, y = display.contentWidth * .25, display.contentWidth * .75, display.contentCenterY
local w, h = display.contentWidth * 0.4, 50

local admob_ids = {
	ios = {
		--banner = 'ca-app-pub-***',
		interstitial = 'ca-app-pub-***',
		rewarded = 'ca-app-pub-***'
	},
	android = {
		--banner ='ca-app-pub-***',
		interstitial = 'ca-app-pub-***',
		rewarded = 'ca-app-pub-***'
	}
}

-- Leave only current system ids
admob_ids = admob_ids[system.getInfo('platform')] or {}

widget.newButton{
	x = xl, y = y - 200,
	width = w, height = h,
	label = 'Init',
	onRelease = function()
		print('init')
		admob.init{
			test = true,
			listener = function(event)
				print(json.prettify(event))
			end
		}
	end}

widget.newButton{
	x = xr, y = y - 200,
	width = w, height = h,
	label = 'Load interstitial',
	onRelease = function()
		print('Load interstitial')
		admob.load{
			type = 'interstitial',
			id = admob_ids.interstitial,
			keywords = {'puzzle', 'game'}
		}
	end}

widget.newButton{
	x = xl, y = y - 120,
	width = w, height = h,
	label = 'Load rewarded',
	onRelease = function()
		print('Load rewarded')
		admob.load{
			type = 'rewarded',
			id = admob_ids.rewarded,
			keywords = {'puzzle', 'game'}
		}
	end}

widget.newButton{
	x = xr, y = y - 120,
	width = w, height = h,
	label = 'Show interstitial',
	onRelease = function()
		print('Show interstitial')
		admob.show('interstitial')
	end}

widget.newButton{
	x = xl, y = y - 40,
	width = w, height = h,
	label = 'Show rewarded',
	onRelease = function()
		print('Show rewarded')
		admob.show('rewarded')
	end}

widget.newButton{
	x = xr, y = y - 40,
	width = w, height = h,
	label = 'Is loaded interstitial?',
	onRelease = function()
		native.showAlert('admob', admob.is_loaded('interstitial') and 'Yes' or 'No', {'OK'})
	end}

widget.newButton{
	x = xl, y = y + 40,
	width = w, height = h,
	label = 'Is loaded rewarded?',
	onRelease = function()
		native.showAlert('admob', admob.is_loaded('rewarded') and 'Yes' or 'No', {'OK'})
	end}
