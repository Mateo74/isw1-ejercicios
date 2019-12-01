class BookListComponent extends React.Component {
  constructor(props) {
    super(props)
		
		this.state = {bookList: []}
  }
	
	buildBookListFrom(catalog, cartContent, includeEntireCatalog) {
		let bookList = []
		
		Object.keys(catalog).forEach((isbn) => {
			let quantity = 0
			if (isbn in cartContent) {
				quantity = cartContent[isbn]
			}
			if (includeEntireCatalog || quantity > 0) {
				bookList.push({
					title: catalog[isbn].title,
					isbn: isbn,
					quantity: quantity,
				})
			}
		})
		
		return bookList
	}
	
	componentDidMount() {
    const {cartID, includeEntireCatalog, router} = this.props
		
		let catalog = {}
		handleErrors(router, request(`catalog`)
			.then((responseBody) => {
				catalog = responseBody
				return request(`listCart?cartID=${cartID}`)
			})
			.then((cartContent) => {
				this.setState( {bookList: this.buildBookListFrom(catalog, cartContent, includeEntireCatalog)} )
			})
		)
	}

	render() {
		const {
			cartID,
			quantityHeading,
			router,
			classes,
		} = this.props
		
		const bookList = this.state.bookList
		
		return (
			<Table className={classes.table} aria-label="simple table">
				<TableHead>
					<TableRow>
						<TableCell>Title</TableCell>
						<TableCell>ISBN</TableCell>
						<TableCell align="center">{quantityHeading}</TableCell>
					</TableRow>
				</TableHead>
				<TableBody>
					{
						bookList.map((item, index) => (
							<TableRow key={index}>
								<TableCell>
									<Button onClick={()=>{}}>{item.title}</Button>
								</TableCell>
								<TableCell>{item.isbn}</TableCell>
								<TableCell align="center">
									<EditableBookQuantity cartID={cartID} isbn={item.isbn} quantity={item.quantity} router={router} />
								</TableCell>
							</TableRow>
						))
					}
				</TableBody>
			</Table>
    )
	}
}

const BookList = withStyles(styles, {
  withTheme: true
})(BookListComponent)
