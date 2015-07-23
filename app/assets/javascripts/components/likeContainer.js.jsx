var likeContainer = React.createClass({
  getInitialState(){
    return {
      liked: this.props.liked,
      likers: this.props.likers
    };
  },
  clickHandler(){
    var liked = this.state.liked;
    if(!this.state.liked){
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
    $.get(this.props.url, function(likersData) {
      var likers = likersData.likers;
      this.setState({likers: likers});
    }.bind(this));
    this.setState({liked: !liked});
  },

  render(){
    return (<div >
              <LikerInfoContainer likers={this.state.likers} />
              <LikeButton 
                clickHandler={this.clickHandler}
                liked={this.state.liked}
                />
               
            </div>);
  }

});
