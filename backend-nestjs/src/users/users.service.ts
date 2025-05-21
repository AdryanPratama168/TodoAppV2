import { Injectable, ConflictException, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from './user.entity';
import { CreateUserDto, LoginUserDto } from './dto/user.dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private usersRepository: Repository<User>,
  ) {}

  async create(createUserDto: CreateUserDto): Promise<User> {
    const { username, password } = createUserDto;
    
    // Check if user already exists
    const existingUser = await this.usersRepository.findOne({ where: { username } });
    if (existingUser) {
      throw new ConflictException('Username already exists');
    }
    
    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);
    
    // Create new user
    const user = this.usersRepository.create({
      username,
      password: hashedPassword,
    });
    
    return this.usersRepository.save(user);
  }
  
  async login(loginUserDto: LoginUserDto): Promise<User> {
    const { username, password } = loginUserDto;
    
    // Find user
    const user = await this.usersRepository.findOne({ where: { username } });
    if (!user) {
      throw new NotFoundException('User not found');
    }
    
    // Compare password
    const isPasswordMatching = await bcrypt.compare(password, user.password);
    if (!isPasswordMatching) {
      throw new NotFoundException('Invalid credentials');
    }
    
    return user;
  }
}