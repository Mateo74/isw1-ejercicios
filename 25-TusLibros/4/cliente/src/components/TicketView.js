class TicketComponent extends React.Component {
    constructor(props) {
      super(props)
    }

    onClickExit() {
      this.props.router.navigate("/", {cartID: -1})
    }
  
    render() {
      return (
        <div>
          <Typography component="h1" gutterBottom>
          Checkout successful! This is the sale ticket:
          </Typography>
          
          <Table size="small">
            <TableBody>
              <TableRow>
                <TableCell>TusLibros Sale Ticket</TableCell>
                <TableCell></TableCell>
              </TableRow>
              <TableRow>
                <TableCell>Credit card number</TableCell>
                <TableCell>{this.props.ticket.card_number}</TableCell>
              </TableRow>
              <TableRow>
                <TableCell>Credit card owner name</TableCell>
                <TableCell>{this.props.ticket.card_owner}</TableCell>
              </TableRow>
              <TableRow>
                <TableCell>Total debited</TableCell>
                <TableCell align="right">{this.props.ticket.total}</TableCell>
              </TableRow>
            </TableBody>
          </Table>

          <Button onClick={() => this.onClickExit()}>
            Exit
          </Button>
        </div>
      )
    }
  }
  
  // Add style
  const TicketView = withStyles(styles, {
    withTheme: true
  })(TicketComponent)
  