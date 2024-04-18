package handlers

import (
	"github.com/labstack/echo/v4"
	"net/http"
	"proba/models"
)

func GetWeather(c echo.Context) error {
	weatherApiUrl := "https://api.open-meteo.com/v1/forecast?latitude=52.2297&longitude=21.0122&current_weather=true"

	weatherResponse, err := models.FetchWeather(weatherApiUrl)
	if err != nil {
		c.Logger().Error(err)
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}

	return c.JSON(http.StatusOK, weatherResponse)
}
