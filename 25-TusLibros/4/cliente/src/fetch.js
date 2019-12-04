const request = (path) => {
  const port = 8000

  return fetch(`http://localhost:${port}/${path}`, {
    method: "GET",
    dataType: "JSON",
    headers: {
      "Access-Control-Request-Headers": "*"
    }
  })
	.then((response) => response.json())
	.then((json) => {
		let errorMessage = json.response["error_message"]
		if (errorMessage != undefined) {
			throw new Error(errorMessage)
		}
		else {
			return json.response
		}
	})
}

const handleErrors = (router, promise) => {
	promise.catch((error) => router.navigate("/error", {errorMessage: error.message}))
}