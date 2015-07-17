var SearchResult = React.createClass({
  render (){
    return (
        <li className="list-group-item">
          <a href={"/users/" + this.props.user.id}>
              {this.props.user.title}
          </a>
        </li>
    );
  }
});
