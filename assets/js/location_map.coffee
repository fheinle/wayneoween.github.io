---
---
up.compiler '.location-map', ($map, currentLocation) ->

	ZOOMFACTOR = 2.5
	isZoomed = false

	initialize = ->
		initializeDom()
		initializeHandlers()

	initializeDom = ->
		@$wrapper = $("<div class='location-map--image-wrapper'></div>")
		@$mapImage = $('<img src="/images/karte/map.jpg" class="location-map--image">')
			.load ->
				addMarkerToCurrentLocation()
		@$marker = $("<div class='location-map--marker pin' style='display: none;'></div>")
		$wrapper.append($mapImage)
		$wrapper.append($marker)
		$map.append($wrapper)

	initializeHandlers = ->
		$wrapper.on('dblclick dbltap', toggleZoom)
		$(window).resize(addMarkerToCurrentLocation)

		# Uncomment the following lines to get the coordinates of a new location
		# by just clicking on it. Usefull for adding new locations.
		# $mapImage.on('click', showLocationCoordinates)

	toggleZoom = (e) ->
		isZoomed = !isZoomed
		if isZoomed
			$wrapper.on('click tap', navigateOnMap)
			navigateOnMap(e)
		else
			$wrapper[0].style.transform = "scale(1)"
			$wrapper.off('click tap', navigateOnMap)

	navigateOnMap = (e) ->
		offset = zoomImageOffset(e)
		$wrapper[0].style.transform = "scale(#{ZOOMFACTOR}) translateX(#{offset.x}px) translateY(#{offset.y}px)"

	zoomImageOffset = (e) ->
		# The top left ankered zoom rectangle should be aligned with the now
		# ZOOMFACTOR smaller image.
		xOffset = mapBoundryOffset(e.target.clientWidth, e.offsetX)
		yOffset = mapBoundryOffset(e.target.clientHeight, e.offsetY)
		{x: xOffset, y: yOffset}

	mapBoundryOffset = (maxLength, offset) ->
		zoomedBoxLength = maxLength / ZOOMFACTOR
		leftBorder = 0
		rightBorder = maxLength - zoomedBoxLength
		zoomedOffset = offset - zoomedBoxLength / 2
		- Math.min(Math.max(zoomedOffset, leftBorder), rightBorder)

	coordinateMatrix = {
		# This is just as an example
		# 'Amphail': {x: 38.67, y: 71.96},
	}

	addMarkerToCurrentLocation = () ->
		coordinates = deNormalizeCoordinates(coordinateMatrix[currentLocation])
		$marker.css('left', "#{coordinates.x}px")
		$marker.css('top', "#{coordinates.y}px")
		$marker.fadeIn('fast')

	showLocationCoordinates = (e) ->
		location = prompt("What's the name of this location?")
		coordinates = relativeClickingCoordinates(e)
		if location
			alert("'#{location}': {x: #{coordinates.x}, y: #{coordinates.y}},")

	relativeClickingCoordinates = (e) ->
		# Normalized percentual coordinates [x,y] in [0..100]²
		x = normalizeCoordinate(e.offsetX / e.target.clientWidth)
		y = normalizeCoordinate(e.offsetY / e.target.clientHeight)
		{x: x, y: y}

	normalizeCoordinate = (coordinate) ->
		_.round(coordinate * 100, 2)

	deNormalizeCoordinates = (percentualCoordinates) ->
		{
			x: percentualCoordinates.x * $mapImage[0].clientWidth / 100,
			y: percentualCoordinates.y * $mapImage[0].clientHeight / 100
		}

	initialize()

	# Ideas:
	# walking days
	# riding days
	# flight time

	true
