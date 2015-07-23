var likeContainer = React.createClass({
  getInitialState(){
    return {
      liked: this.props.liked
    };
  },
  clickHandler(){
    var liked = this.state.liked;
    if(liked){
      $.ajax({
        method: "POST",
        url: this.props.url,
        data: { id: this.props.id },
        success: function(x){
          console.log('yes', x);
        }
      });
    }
    else{
      $.ajax({
        method: "DELETE",
        url: this.props.url,
        data: { id: this.props.id },
        success: function(x){
          console.log('no', x);
        }
      });
    }
    this.setState({liked: !liked});
  },

  render(){
    return (<div >
              <LikeButton 
                clickHandler={this.clickHandler}
                liked={this.state.liked}
                />
            </div>);
  }

});
