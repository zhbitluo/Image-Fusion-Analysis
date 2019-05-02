% Parameters:
%     problem; name of optimization problem
%     data; data-struct, see e.g. the file myproblemdata.m
%     parameters; behavioural parameters for optimizer,
%                 see file psoparameters.m
% Returns:
%     bestX; best found position in the search-space.
%     bestFitness; fitness of bestX.
%     evaluations; number of fitness evaluations performed.
function [z_n,bestFitness,EFB,ES,EP] = pso_new(problem,dim,evals)
    global wp ws C Q P c
    % Copy data contents to local variables for convenience.
    n = dim/2;
    acceptableFitness = 10^(-10);
    maxEvaluations = evals;
    % Behavioural parameters for this optimizer.
    s = 1000;       % Swarm-size
    xmin=-1;
    xmax=1;
    M=(xmax-xmin)/2;
    % Initialize swarm.
    x = initpopulation(s, n);     % Particle positions.
    p = x;                                                        % Best-known positions.
    % Compute fitness of initial particle positions.
    fitness = zeros(1, s); % Preallocate array for efficiency.
    for i=1:s
        fitness(i) = feval(problem, x(i,:));
    end;
    % Determine fitness and index of best particle.
    [bestFitness, bestIndex] = min(fitness);
    count=0;
    evaluations = s; % Fitness evaluations above count as iterations.
    while (evaluations < maxEvaluations) && (bestFitness > acceptableFitness)
        % Pick index for a random particle from the swarm.
        i = ceil(s * rand(1,1));
        alpha=0.75;
        mbest=sum(p)/s;
%         fi=rand(1,n);
%         p_local=fi.*p(i,:)+(1-fi).*p(bestIndex,:);
%         u=rand(1,n);
%         x(i,:)= p_local+((-1).^ceil(0.5+rand(1,n))).*(alpha.*abs(mbest-x(i,:)).*log10(1./u));
%         x(i,:)=x(i,:)-(xmax+xmin)/2;
%         x(i,:)=sign(x(i,:)).*min(abs(x(i,:)),M);
%         x(i,:)=x(i,:)+(xmax+xmin)/2;
        for d=1:n
            fi=rand(1,1);
            p_local=fi.*p(i,d)+(1-fi).*p(bestIndex,d);
            u=rand(1,1);
            if rand > 0.5
                x(i,d)=p_local+alpha*abs(mbest(d)-x(i,d))*log(1/u);
            else
                x(i,d)=p_local-alpha*abs(mbest(d)-x(i,d))*log(1/u);
            end;
            if x(i,d)>xmax
                x(i,d)=xmax;
            end;
            if x(i,d)< -xmin
                x(i,d)=-xmin;
            end;
        end;         
        [newFitness,EFB,ES,EP] = feval(problem,x(i,:));
        % Update best-known positions.
        if newFitness < fitness(i)
            % Update particle's best-known fitness.
            fitness(i) = newFitness;
            % Update particle's best-known position.
            p(i,:) = x(i,:);
            % Update swarm's best-known position.
           if newFitness < bestFitness
                % Index into the p array.
                bestIndex = i;                
                bestFitness = newFitness;
           end;
        end;
        evaluations = evaluations + 1;
    end;
    bestX = p(bestIndex,:);
    W = linspace(0,pi,1000);
    z_d=firpm(n-1,[0 wp ws pi]/pi,[1 1 0 0]);
    p_d=1;
    H_d = abs(freqz(z_d,p_d,W));
    z_n =[bestX fliplr(bestX)];
    p_n=1;
    H_n=abs(freqz(z_n,p_n,W));    
    K_n = sum(H_d)./sum(H_n);
    H_n = K_n.*H_n;
    z_n=K_n*z_n;
    z_n=z_n/sum(z_n);
end
