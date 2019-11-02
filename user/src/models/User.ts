import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import { Document, model, Model, Schema } from 'mongoose';
import { Location } from './Location';

class User {
    public static model: Model<Document> = model(
        'User',
        new Schema({
            email: { type: String, required: true, unique: true, dropDups: true },
            username: { type: String, required: true, unique: true, dropDups: true },
            password: { type: String, required: true },
            fullName: { type: String, required: true },
            timeCreated: { type: Date, required: true, default: new Date() },
            dateOfBirth: { type: Date },
            location: { type: { type: Schema.Types.ObjectId, ref: 'Location' } },
            token: { type: String },
        })
    );
    private static readonly SALT_ROUNDS = 10;

    private user: Document;
    private location: Location | undefined;

    public constructor(user: any) {
        const { email, username, password, fullName, dateOfBirth, location } = user;
        this.user = new User.model({
            email,
            username,
            password: this.hashPassword(password),
            fullName,
            timeCreated: Date.now(),
            dateOfBirth,
            token: null,
        });

        if (this.locationIsValid(location)) {
            this.location = new Location(location);
            this.user.set('location', this.location.getObjectID());
        }
    }

    public getDocument(): Document {
        return this.user;
    }

    public getUsername(): string {
        return this.user.get('username');
    }

    public setUsername(username: string): void {
        this.user.set('username', username);
    }

    public getPassword(): string {
        return this.user.get('password');
    }

    public setPassword(password: string): void {
        this.user.set('password', password);
    }

    public save(): Promise<Document> {
        return this.user.save();
    }

    public async passwordsMatch(password: string): Promise<boolean> {
        return bcrypt.compare(password, this.getPassword());
    }

    public assignNewToken(): string {
        const newToken: string = this.generateToken();
        this.user.set('token', newToken);
        return newToken;
    }

    private generateToken(): string {
        let token: string = '';

        const secretKey: string | undefined = process.env.JWT_SECRET_KEY;
        const payload: object = { username: this.getUsername(), iat: Date.now() };

        if (secretKey) {
            token = jwt.sign(payload, secretKey, { expiresIn: '168h' });
        } else {
            throw new Error('Secret key is not defined.');
        }

        return token;
    }

    private hashPassword(password: string): string {
        return bcrypt.hashSync(password, User.SALT_ROUNDS);
    }

    private locationIsValid(location: any): boolean {
        return location.city !== undefined && location.province !== undefined && location.country !== undefined;
    }
}

export { User };
