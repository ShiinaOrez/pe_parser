package main

import (
	"debug/pe"
	"encoding/json"

	"github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"
	"github.com/go-gl/glfw/v3.3/glfw"
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(400, 600),
	flutter.AddPlugin(&PeAnalyst{}),
}

type PeAnalyst struct {
	window   *glfw.Window
	filePath string
}

type PeError struct {
	Type     string `json:"type"`
	ErrorMsg string `json:"error_msg"`
}

var _ flutter.Plugin = &PeAnalyst{}
var _ flutter.PluginGLFW = &PeAnalyst{}

func (a *PeAnalyst) InitPlugin(messenger plugin.BinaryMessenger) error {
	channel := plugin.NewMethodChannel(messenger, "shiina/orez", plugin.StandardMethodCodec{})
	channel.HandleFunc("analysis", a.analysis)
	return nil
}

func (a *PeAnalyst) InitPluginGLFW(window *glfw.Window) error {
	a.window = window
	return nil
}

func (a PeAnalyst) analysis(arguments interface{}) (reply interface{}, err error) {
	argumentsMap, ok := arguments.(map[interface{}]interface{})
	if !ok {
		return buildPeErrorStr("Err01 - Invoke method arguments mistake", "Type assert failed. "), nil
	}
	a.filePath = argumentsMap["filePath"].(string)
	peFile, err := pe.Open(a.filePath)
	if err != nil {
		return buildPeErrorStr("Err02 - Open PE file failed", err.Error()), nil
	}
	defer peFile.Close()
	bs, _ := json.Marshal(peFile)
	return string(bs), nil
}

func buildPeErrorStr(t, msg string) string {
	errMsg := PeError{
		Type:     t,
		ErrorMsg: msg,
	}
	bs, _ := json.Marshal(errMsg)
	return string(bs)
}
