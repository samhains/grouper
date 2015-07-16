var SearchResult = React.createClass({
  render (){
    return (
        <li className="list-group-item">
          <a href={"/videos/" + this.props.video.id}>
              {this.props.video.title}
          </a>
        </li>
    );
  }
});
