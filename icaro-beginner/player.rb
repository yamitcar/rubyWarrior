class Player

  def initialize
    @health = 20
    @took_safety_attitude = false
  end

  def play_turn(warrior)
      @warrior = warrior

      if are_you_under_attack? or @warrior.feel.enemy?
        if are_you_healthy?
          take_offensive_attitude
        else
          take_safety_attitude
        end
      else
          take_defensive_attitude
      end
      update_health
  end

  private

  def take_safety_attitude
    puts 'Icaro take safety attitude'
    if(@took_safety_attitude)
      walk
    else
      @took_safety_attitude = true
      walk true
    end
  end

  def take_defensive_attitude
    puts 'Icaro take defensive attitude'
    if @warrior.feel.stairs?
      walk
    elsif @warrior.feel.captive?
      @warrior.rescue!
    elsif @health <= 13
      @warrior.rest!
    else
        walk
    end
    @took_safety_attitude = false
  end

  def take_offensive_attitude
    puts 'Icaro take offensive attitude'
    if @warrior.feel.enemy?
      @warrior.attack!
    else
      walk
    end
    @took_safety_attitude = false
  end

  def are_you_healthy?
    @health >= 9
  end

  def are_you_under_attack?
    @health > @warrior.health
  end

  def update_health
    @health = @warrior.health
  end

  def walk(opposite = false)
    if @warrior.feel.wall?
      puts 'pivot for wall!'
      @warrior.pivot!
    else
      if opposite
        @warrior.walk!(:backward)
      else
        @warrior.walk!
      end
    end
  end
end
